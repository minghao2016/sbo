context("comparing get_kgram_freqs() and get_kgram_freqs_fast()")

test_that("coincidence on long char vector", {
        freqs <- get_kgram_freqs(twitter_train[1:10000], 3, twitter_dict)
        freqs_fast <- get_kgram_freqs_fast(twitter_train[1:10000], 3, twitter_dict)
        
        transform <- . %>% arrange(across(starts_with("w")))
        
        freqs_attr_bckp <- attributes(freqs)
        freqs %<>% lapply(transform)
        attributes(freqs) <- freqs_attr_bckp
        freqs_fast_attr_bckp <- attributes(freqs_fast) 
        freqs_fast %<>% lapply(transform)
        attributes(freqs_fast) <- freqs_fast_attr_bckp 
        
        attr(freqs_fast, ".preprocess") <- attr(freqs, ".preprocess")
        expect_identical(freqs, freqs_fast)
})

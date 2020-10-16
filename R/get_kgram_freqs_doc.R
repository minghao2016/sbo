################################################################################
#'
#' \eqn{latex}{k}-gram frequency tables
#'
#' Get \eqn{latex}{k}-gram frequency tables from a training corpus.
#'
#' @author Valerio Gherardi
#' @md
#'
#'
#' @param text a character vector. The training corpus from which to extract
#' k-gram frequencies.
#' @param N a length one integer. The maximum order of \eqn{latex}{k}-grams
#' for which frequencies are sought.
#' @param dict either a character vector, or a length one integer/numeric.
#' The language model fixed dictionary (see details), sorted by word frequency.
#' If numeric, the dictionary is obtained from the training corpus using
#' the \code{dict} most frequent words.
#' @param .preprocess a function to apply before \eqn{latex}{k}-gram
#' tokenization.
#' @param erase a length one character vector. Regular expression matching
#' parts  of text to be erased from input. The default removes anything not
#' alphanumeric, white space, apostrophes or punctuation characters
#' (i.e. ".?!:;").
#' @param lower_case a length one logical vector. If TRUE, puts everything to
#' lower case.
#' @param EOS a length one character vector listing all (single character)
#' end-of-sentence tokens.
#' @return A \code{kgram_freqs} object, containing the \eqn{latex}{k}-gram
#' frequency tables for \eqn{latex}{k = 1, 2, ..., N}.
#' @details These functions extract all k-gram frequency tables from a text
#' corpus up to a specified \eqn{latex}{k}-gram order \eqn{latex}{N}. These are
#' the building blocks to train any \eqn{latex}{N}-gram model.
#'
#' The optimized version \code{get_kgram_freqs_fast(erase = x, lower_case = y)}
#' is equivalent to
#' \code{get_kgram_freqs(.preprocess = preprocess(erase = x, lower_case = y))},
#' but more efficient (both from the speed and memory point of view).
#'
#' \code{get_kgram_freqs} and \code{get_kgram_freqs_fast} employ a fixed
#' (user specified) dictionary; any out-of-vocabulary word gets effectively
#' replaced by an "unknown word" token.
#'
#' The return value is a "\code{kgram_freqs}" object, i.e. a list containing:
#'
#' - The highest order of \eqn{latex}{N}-grams, \eqn{latex}{N}.
#' - The reference dictionary, sorted by word frequency. This can be obtained
#' using \code{\link[sbo]{get_word_freqs}}.
#' - A list of n tibbles, storing frequency counts for each
#' \eqn{latex}{k}-gram observed in the training corpus, for
#' \eqn{latex}{k = 1, 2, ..., N}. In these tibbles, words are represented by
#' integer numbers corresponding to their position in the
#' reference dictionary. The special codes \code{0},
#' \code{length(dictionary)+1} and \code{length(dictionary)+2}
#' correspond to the "Begin-Of-Sentence", "End-Of-Sentence"
#' and "Unknown word" tokens, respectively.
#' - The function used for text preprocessing (i.e. the .preprocess argument)
#' - A length one character vector listing all (single character)
#' end-of-sentence tokens. (i.e. EOS argument)
#'
#' The \code{.preprocess} argument of \code{get_kgram_freqs} allows the user to
#' employ a custom corpus preprocessing function.
#'
#' The algorithm for \eqn{k}-gram tokenization considers anything separated by
#' (any number of) white spaces (i.e. " ") as a single word. Sentences are split
#' according to end-of-sentence (single character) tokens, as specified
#' by the `EOS` argument. Additionally text belonging to different entries of
#' the preprocessed input vector which are understood to belong to different
#' sentences.
#'
#' @seealso \code{\link[sbo]{get_word_freqs}}
#' @name get_kgram_freqs
################################################################################
NULL
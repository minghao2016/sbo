#include "sbo.h"

void tokenize_sentences(std::string str, std::vector<std::string>& sentences,
                        const std::regex& _EOS, const std::string eos){
        str = eos + str + eos;
        str = std::regex_replace(str, _EOS, eos);
        size_t end;
        size_t start = str.find_first_not_of(eos);
        while((end = str.find_first_of(eos, start)) != std::string::npos){
                sentences.push_back(str.substr(start, end - start));
                start = str.find_first_not_of(eos, end);
        }
}

//' @export
// [[Rcpp::export]]
std::vector<std::string> tokenize_sentences(const std::vector<std::string>& input,
                                            std::string EOS = ".?!:;"){
        if(EOS == "") return input;
        std::vector<std::string> sentences;
        std::regex _EOS(R"((\s*[)" + EOS + R"(]+\s*)+)");
        const std::string eos = EOS.substr(0, 1);
        for(const std::string& str : input)
                tokenize_sentences(str, sentences, _EOS, eos);
        return sentences;
}


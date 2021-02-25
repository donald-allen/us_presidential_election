function out_text = add_ipa_from_existing_words(thisWord, word_list,ipa_list)
out_text = ''; 
proposed_word = '';

% Search for singular it this word is a plural
plural_vowel = {'as','es','is','os','us', 'ás', 'és', 'ís', 'ós', 'ús'};
if any(cellfun(@(x) endsWith(thisWord,x), plural_vowel))
    searchWord = thisWord(1:end-1); % make singular
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx};
        proposed_word(end+1) = 's';
    end
end


% Search for plural if this word is a singular
sing_vowel = {'á', 'é', 'í', 'ó', 'ú','a','e','i','o','u'};
if any(cellfun(@(x) endsWith(thisWord,x), sing_vowel))
    searchWord = thisWord; searchWord(end+1) = 's'; % make plural
    
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx}(1:end-1);
    end
end

% Search for plural if word ends in -r or -z
if endsWith(thisWord,'r') || endsWith(thisWord,'z')
    searchWord = [thisWord 'es'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx} 'is'];
    end
end

% Search for singular if word ends in -res or -zes
if endsWith(thisWord,'res') || endsWith(thisWord,'zes')
    searchWord = thisWord(1:end-2);
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx}(1:end-2);
    end
end

% Search for plural if word ends in vowel + -l
if any(cellfun(@(x) endsWith(thisWord,sprintf('%sl',x)), {'a','e','i','o','u'}))
    searchWord = [thisWord(1:end-1) 'is'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx}(1:end-2) 'w'];
    end
end

% Search for singular if word ends in -is
if endsWith(thisWord,'is')
    searchWord = [thisWord(1:end-2) 'l'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx}(1:end-1) 'js'];
    end
end

% Search for plural if word ends in -ês
if endsWith(thisWord,'ês')
    searchWord = [thisWord(1:end-2) 'eses'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx}(1:end-1) 'zes'];
    end
end

% Search for singular if word ends in -eses
if endsWith(thisWord,'eses')
    searchWord = [thisWord(1:end-4) 'ês'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx}(1:end-4) 'es'];
    end
end

% Search for plural if word ends in -m
if endsWith(thisWord,'m')
    searchWord = [thisWord(1:end-1) 'ns'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        if all(double(ipa_list{match_ndx}(end-1:end))==[106 771])
            proposed_word = [ipa_list{match_ndx}(1:end-2) 's'];
        elseif endsWith(ipa_list{match_ndx},'ẽj')
            proposed_word = [ipa_list{match_ndx}(1:end-1) 's'];
        end
    end
end

% Search for singular if word ends in -ns
if endsWith(thisWord,'ns')
    searchWord = [thisWord(1:end-2) 'm'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx}(1:end-1) char(double([106 771]))];
    end
end

% Search for plural if word ends in -ão
if endsWith(thisWord,'ão')
    searchWord = [thisWord(1:end-1) 'ães'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx}(1:end-1) char([106 771]) 's'];
    end
    
    searchWord = [thisWord(1:end-1) 'ões'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx}(1:end-2) 'õ' char([106 771]) 's'];
    end
end

% Search for singular if word ends in -ães
if endsWith(thisWord,'ães')
    searchWord = [thisWord(1:end-2) 'o'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx}(1:end-3) char([119 771])];
    end
end

% Search for singular if word ends in -ões
if endsWith(thisWord,'ões')
    searchWord = [thisWord(1:end-2) 'o'];
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = [ipa_list{match_ndx}(1:end-4) 'ã' char([119 771])];
    end
end



% Search for -a when -o exists
if endsWith(thisWord,'a')
    
    % Search for -a when -o exists
    searchWord = thisWord; searchWord(end) = 'o';
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx};
        proposed_word(end) = 'ɐ';
    end
    
    % Search for -a when -os exists
    searchWord = thisWord; searchWord(end:end+1) = 'os';
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx}(1:end-2);
        proposed_word(end+1) = 'ɐ';
    end
end

if endsWith(thisWord,'o')
    % Search for -o when -a exists
    searchWord = thisWord; searchWord(end) = 'a';
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx};
        proposed_word(end) = 'u';
    end
    
    % Search for -o when -as exists
    searchWord = thisWord; searchWord(end:end+1) = 'as';
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx}(1:end-2);
        proposed_word(end+1) = 'u';
    end
end

if endsWith(thisWord,'as')
    % Search for -as when -os exists
    searchWord = thisWord; searchWord(end:end+1) = 'os';
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx};
        proposed_word(end-1) = 'u';
    end
    
    % Search for -as when -o exists
    searchWord = thisWord(1:end-2); searchWord(end+1) = 'o';
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx};
        proposed_word(end:end+1) = 'us';
    end
end

if endsWith(thisWord,'os')
    % Search for -os when -as exists
    searchWord = thisWord; searchWord(end:end+1) = 'as';
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx};
        proposed_word(end-1) = 'ɐ';
    end
    
    % Search for -os when -a exists
    searchWord = thisWord(1:end-2); searchWord(end+1) = 'a';
    match_ndx = find(strcmp(word_list,searchWord));
    if ~isempty(match_ndx) && ~isempty(ipa_list{match_ndx})
        proposed_word = ipa_list{match_ndx};
        proposed_word(end:end+1) = 'ɐs';
    end
end

% Search for regular -AR present tense verb ending

% Search for regular -IR present tense ending

if ~isempty(proposed_word)
    % Include the desired Default answer
    opts.Default = 'Yes';
    % Use the TeX interpreter to format the question
    quest = sprintf('Do you want to replace %s with %s?',thisWord,proposed_word);
    answer = questdlg(quest,'Boundary Condition',...
        'Yes','No','Yes');
    
    if strcmp(answer,'Yes')
        out_text = proposed_word;
    end
end
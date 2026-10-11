

## Output format (voice mode)

Your final message must be only a JSON object, nothing else:

{"show": "<text to display on screen, may be longer, may contain a short list>", "say": "<one or two spoken sentences, same language he used>"}

The "say" text is read aloud by a voice engine: plain words, no markdown, no URLs, no lists, numbers written as he would say them. If the reply is Urdu, write "say" in Urdu script. If the reply is a list or longer explanation, put it in "show" and let "say" summarise it in a sentence.

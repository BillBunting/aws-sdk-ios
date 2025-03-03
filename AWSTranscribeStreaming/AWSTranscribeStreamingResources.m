//
// Copyright 2010-2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSTranscribeStreamingResources.h"
#import <AWSCore/AWSCocoaLumberjack.h>

@interface AWSTranscribeStreamingResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSTranscribeStreamingResources

+ (instancetype)sharedInstance {
    static AWSTranscribeStreamingResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSTranscribeStreamingResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSDDLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (nonnull NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2017-10-26\",\
    \"endpointPrefix\":\"transcribestreaming\",\
    \"protocol\":\"rest-json\",\
    \"protocolSettings\":{\"h2\":\"eventstream\"},\
    \"serviceFullName\":\"Amazon Transcribe Streaming Service\",\
    \"serviceId\":\"Transcribe Streaming\",\
    \"signatureVersion\":\"v4\",\
    \"signingName\":\"transcribe\",\
    \"uid\":\"transcribe-streaming-2017-10-26\"\
  },\
  \"operations\":{\
    \"StartStreamTranscription\":{\
      \"name\":\"StartStreamTranscription\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/stream-transcription\"\
      },\
      \"input\":{\"shape\":\"StartStreamTranscriptionRequest\"},\
      \"output\":{\"shape\":\"StartStreamTranscriptionResponse\"},\
      \"errors\":[\
        {\"shape\":\"BadRequestException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalFailureException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"ServiceUnavailableException\"}\
      ],\
      \"documentation\":\"<p>Starts a bidirectional HTTP2 stream where audio is streamed to Amazon Transcribe and the transcription results are streamed to your application.</p> <p>The following are encoded as HTTP2 headers:</p> <ul> <li> <p>x-amzn-transcribe-language-code</p> </li> <li> <p>x-amzn-transcribe-media-encoding</p> </li> <li> <p>x-amzn-transcribe-sample-rate</p> </li> <li> <p>x-amzn-transcribe-session-id</p> </li> </ul>\"\
    }\
  },\
  \"shapes\":{\
    \"Alternative\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Transcript\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The text that was transcribed from the audio.</p>\"\
        },\
        \"Items\":{\
          \"shape\":\"ItemList\",\
          \"documentation\":\"<p>One or more alternative interpretations of the input audio. </p>\"\
        }\
      },\
      \"documentation\":\"<p>A list of possible transcriptions for the audio.</p>\"\
    },\
    \"AlternativeList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Alternative\"}\
    },\
    \"AudioChunk\":{\"type\":\"blob\"},\
    \"AudioEvent\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AudioChunk\":{\
          \"shape\":\"AudioChunk\",\
          \"documentation\":\"<p>An audio blob that contains the next part of the audio that you want to transcribe.</p>\",\
          \"eventpayload\":true\
        }\
      },\
      \"documentation\":\"<p>Provides a wrapper for the audio chunks that you are sending.</p>\",\
      \"event\":true\
    },\
    \"AudioStream\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AudioEvent\":{\
          \"shape\":\"AudioEvent\",\
          \"documentation\":\"<p>A blob of audio from your application. You audio stream consists of one or more audio events.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the audio stream from your application to Amazon Transcribe.</p>\",\
      \"eventstream\":true\
    },\
    \"BadRequestException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>One or more arguments to the <code>StartStreamTranscription</code> operation was invalid. For example, <code>MediaEncoding</code> was not set to <code>pcm</code> or <code>LanguageCode</code> was not set to a valid code. Check the parameters and try your request again.</p>\",\
      \"error\":{\"httpStatusCode\":400},\
      \"exception\":true\
    },\
    \"Boolean\":{\"type\":\"boolean\"},\
    \"ConflictException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>A new stream started with the same session ID. The current stream has been terminated.</p>\",\
      \"error\":{\"httpStatusCode\":409},\
      \"exception\":true\
    },\
    \"Double\":{\"type\":\"double\"},\
    \"InternalFailureException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>A problem occurred while processing the audio. Amazon Transcribe terminated processing. Try your request again.</p>\",\
      \"error\":{\"httpStatusCode\":500},\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"Item\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"StartTime\":{\
          \"shape\":\"Double\",\
          \"documentation\":\"<p>The offset from the beginning of the audio stream to the beginning of the audio that resulted in the item.</p>\"\
        },\
        \"EndTime\":{\
          \"shape\":\"Double\",\
          \"documentation\":\"<p>The offset from the beginning of the audio stream to the end of the audio that resulted in the item.</p>\"\
        },\
        \"Type\":{\
          \"shape\":\"ItemType\",\
          \"documentation\":\"<p>The type of the item. <code>PRONUNCIATION</code> indicates that the item is a word that was recognized in the input audio. <code>PUNCTUATION</code> indicates that the item was interpreted as a pause in the input audio.</p>\"\
        },\
        \"Content\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The word or punctuation that was recognized in the input audio.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A word or phrase transcribed from the input audio.</p>\"\
    },\
    \"ItemList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Item\"}\
    },\
    \"ItemType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"PRONUNCIATION\",\
        \"PUNCTUATION\"\
      ]\
    },\
    \"LanguageCode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"en-US\",\
        \"en-GB\",\
        \"es-US\",\
        \"fr-CA\",\
        \"fr-FR\",\
        \"en-AU\",\
        \"it-IT\",\
        \"de-DE\",\
        \"pt-BR\",\
        \"ja-JP\",\
        \"ko-KR\",\
        \"zh-CN\",\
        \"th-TH\",\
        \"es-ES\",\
        \"ar-SA\",\
        \"pt-PT\",\
        \"ca-ES\",\
        \"ar-AE\",\
        \"hi-IN\",\
        \"zh-HK\",\
        \"nl-NL\",\
        \"no-NO\",\
        \"sv-SE\",\
        \"pl-PL\",\
        \"fi-FI\",\
        \"zh-TW\",\
        \"en-IN\",\
        \"en-IE\",\
        \"en-NZ\",\
        \"en-AB\",\
        \"en-ZA\",\
        \"en-WL\",\
        \"de-CH\",\
        \"af-ZA\",\
        \"eu-ES\",\
        \"hr-HR\",\
        \"cs-CZ\",\
        \"da-DK\",\
        \"fa-IR\",\
        \"gl-ES\",\
        \"el-GR\",\
        \"he-IL\",\
        \"id-ID\",\
        \"lv-LV\",\
        \"ms-MY\",\
        \"ro-RO\",\
        \"ru-RU\",\
        \"sr-RS\",\
        \"sk-SK\",\
        \"so-SO\",\
        \"tl-PH\",\
        \"uk-UA\",\
        \"vi-VN\",\
        \"zu-ZA\"\
      ]\
    },\
    \"LimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>You have exceeded the maximum number of concurrent transcription streams, are starting transcription streams too quickly, or the maximum audio length of 4 hours. Wait until a stream has finished processing, or break your audio stream into smaller chunks and try your request again.</p>\",\
      \"error\":{\"httpStatusCode\":429},\
      \"exception\":true\
    },\
    \"MediaEncoding\":{\
      \"type\":\"string\",\
      \"enum\":[\"pcm\"]\
    },\
    \"MediaSampleRateHertz\":{\
      \"type\":\"integer\",\
      \"max\":48000,\
      \"min\":8000\
    },\
    \"RequestId\":{\"type\":\"string\"},\
    \"Result\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"ResultId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A unique identifier for the result. </p>\"\
        },\
        \"StartTime\":{\
          \"shape\":\"Double\",\
          \"documentation\":\"<p>The offset in milliseconds from the beginning of the audio stream to the beginning of the result.</p>\"\
        },\
        \"EndTime\":{\
          \"shape\":\"Double\",\
          \"documentation\":\"<p>The offset in milliseconds from the beginning of the audio stream to the end of the result.</p>\"\
        },\
        \"IsPartial\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p> <code>true</code> to indicate that Amazon Transcribe has additional transcription data to send, <code>false</code> to indicate that this is the last transcription result for the audio stream.</p>\"\
        },\
        \"Alternatives\":{\
          \"shape\":\"AlternativeList\",\
          \"documentation\":\"<p>A list of possible transcriptions for the audio. Each alternative typically contains one <code>item</code> that contains the result of the transcription.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The result of transcribing a portion of the input audio stream. </p>\"\
    },\
    \"ResultList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Result\"}\
    },\
    \"SessionId\":{\
      \"type\":\"string\",\
      \"pattern\":\"[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\"\
    },\
    \"StartStreamTranscriptionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"LanguageCode\",\
        \"MediaSampleRateHertz\",\
        \"MediaEncoding\",\
        \"AudioStream\"\
      ],\
      \"members\":{\
        \"LanguageCode\":{\
          \"shape\":\"LanguageCode\",\
          \"documentation\":\"<p>Indicates the language used in the input audio stream.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-language-code\"\
        },\
        \"MediaSampleRateHertz\":{\
          \"shape\":\"MediaSampleRateHertz\",\
          \"documentation\":\"<p>The sample rate, in Hertz, of the input audio. We suggest that you use 8000 Hz for low quality audio and 16000 Hz for high quality audio.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-sample-rate\"\
        },\
        \"MediaEncoding\":{\
          \"shape\":\"MediaEncoding\",\
          \"documentation\":\"<p>The encoding used for the input audio. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-media-encoding\"\
        },\
        \"VocabularyName\":{\
          \"shape\":\"VocabularyName\",\
          \"documentation\":\"<p>The name of the vocabulary to use when processing the transcription job.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-vocabulary-name\"\
        },\
        \"SessionId\":{\
          \"shape\":\"SessionId\",\
          \"documentation\":\"<p>A identifier for the transcription session. Use this parameter when you want to retry a session. If you don't provide a session ID, Amazon Transcribe will generate one for you and return it in the response.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-session-id\"\
        },\
        \"AudioStream\":{\
          \"shape\":\"AudioStream\",\
          \"documentation\":\"<p>PCM-encoded stream of audio blobs. The audio stream is encoded as an HTTP2 data frame.</p>\"\
        }\
      },\
      \"payload\":\"AudioStream\"\
    },\
    \"StartStreamTranscriptionResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"RequestId\":{\
          \"shape\":\"RequestId\",\
          \"documentation\":\"<p>An identifier for the streaming transcription.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-request-id\"\
        },\
        \"LanguageCode\":{\
          \"shape\":\"LanguageCode\",\
          \"documentation\":\"<p>The language code for the input audio stream.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-language-code\"\
        },\
        \"MediaSampleRateHertz\":{\
          \"shape\":\"MediaSampleRateHertz\",\
          \"documentation\":\"<p>The sample rate for the input audio stream. Use 8000 Hz for low quality audio and 16000 Hz for high quality audio.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-sample-rate\"\
        },\
        \"MediaEncoding\":{\
          \"shape\":\"MediaEncoding\",\
          \"documentation\":\"<p>The encoding used for the input audio stream.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-media-encoding\"\
        },\
        \"VocabularyName\":{\
          \"shape\":\"VocabularyName\",\
          \"documentation\":\"<p>The name of the vocabulary used when processing the job.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-vocabulary-name\"\
        },\
        \"SessionId\":{\
          \"shape\":\"SessionId\",\
          \"documentation\":\"<p>An identifier for a specific transcription session.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amzn-transcribe-session-id\"\
        },\
        \"TranscriptResultStream\":{\
          \"shape\":\"TranscriptResultStream\",\
          \"documentation\":\"<p>Represents the stream of transcription events from Amazon Transcribe to your application.</p>\"\
        }\
      },\
      \"payload\":\"TranscriptResultStream\"\
    },\
    \"String\":{\"type\":\"string\"},\
    \"Transcript\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Results\":{\
          \"shape\":\"ResultList\",\
          \"documentation\":\"<p> <a>Result</a> objects that contain the results of transcribing a portion of the input audio stream. The array can be empty.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The transcription in a <a>TranscriptEvent</a>.</p>\"\
    },\
    \"TranscriptEvent\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Transcript\":{\
          \"shape\":\"Transcript\",\
          \"documentation\":\"<p>The transcription of the audio stream. The transcription is composed of all of the items in the results list.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents a set of transcription results from the server to the client. It contains one or more segments of the transcription.</p>\",\
      \"event\":true\
    },\
    \"TranscriptResultStream\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"TranscriptEvent\":{\
          \"shape\":\"TranscriptEvent\",\
          \"documentation\":\"<p>A portion of the transcription of the audio stream. Events are sent periodically from Amazon Transcribe to your application. The event can be a partial transcription of a section of the audio stream, or it can be the entire transcription of that portion of the audio stream. </p>\"\
        },\
        \"BadRequestException\":{\
          \"shape\":\"BadRequestException\",\
          \"documentation\":\"<p>A client error occurred when the stream was created. Check the parameters of the request and try your request again.</p>\"\
        },\
        \"LimitExceededException\":{\
          \"shape\":\"LimitExceededException\",\
          \"documentation\":\"<p>Your client has exceeded one of the Amazon Transcribe limits, typically the limit on audio length. Break your audio stream into smaller chunks and try your request again.</p>\"\
        },\
        \"InternalFailureException\":{\
          \"shape\":\"InternalFailureException\",\
          \"documentation\":\"<p>A problem occurred while processing the audio. Amazon Transcribe terminated processing.</p>\"\
        },\
        \"ConflictException\":{\
          \"shape\":\"ConflictException\",\
          \"documentation\":\"<p>A new stream started with the same session ID. The current stream has been terminated.</p>\"\
        },\
        \"ServiceUnavailableException\":{\
          \"shape\":\"ServiceUnavailableException\",\
          \"documentation\":\"<p>The service is currently unavailable. Try your request later.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents the transcription result stream from Amazon Transcribe to your application.</p>\",\
      \"eventstream\":true\
    },\
    \"VocabularyName\":{\
      \"type\":\"string\",\
      \"max\":200,\
      \"min\":1,\
      \"pattern\":\"^[0-9a-zA-Z._-]+\"\
    }\
  },\
  \"documentation\":\"<p>Operations and objects for transcribing streaming speech to text.</p>\"\
}";
}

@end

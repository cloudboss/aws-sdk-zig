const CaseSummarizationChunkDataDetails = @import("case_summarization_chunk_data_details.zig").CaseSummarizationChunkDataDetails;
const ContentDataDetails = @import("content_data_details.zig").ContentDataDetails;
const EmailGenerativeAnswerChunkDataDetails = @import("email_generative_answer_chunk_data_details.zig").EmailGenerativeAnswerChunkDataDetails;
const EmailOverviewChunkDataDetails = @import("email_overview_chunk_data_details.zig").EmailOverviewChunkDataDetails;
const EmailResponseChunkDataDetails = @import("email_response_chunk_data_details.zig").EmailResponseChunkDataDetails;
const GenerativeChunkDataDetails = @import("generative_chunk_data_details.zig").GenerativeChunkDataDetails;
const GenerativeDataDetails = @import("generative_data_details.zig").GenerativeDataDetails;
const IntentDetectedDataDetails = @import("intent_detected_data_details.zig").IntentDetectedDataDetails;
const NotesChunkDataDetails = @import("notes_chunk_data_details.zig").NotesChunkDataDetails;
const NotesDataDetails = @import("notes_data_details.zig").NotesDataDetails;
const SourceContentDataDetails = @import("source_content_data_details.zig").SourceContentDataDetails;
const SuggestedMessageDataDetails = @import("suggested_message_data_details.zig").SuggestedMessageDataDetails;

/// Details about the data.
pub const DataDetails = union(enum) {
    /// Details about case summarization chunk data.
    case_summarization_chunk_data: ?CaseSummarizationChunkDataDetails,
    /// Details about the content data.
    content_data: ?ContentDataDetails,
    /// Streaming chunk data for email generative answers containing partial
    /// knowledge-based response content.
    email_generative_answer_chunk_data: ?EmailGenerativeAnswerChunkDataDetails,
    /// Streaming chunk data for email overview containing partial overview content.
    email_overview_chunk_data: ?EmailOverviewChunkDataDetails,
    /// Streaming chunk data for email response generation containing partial
    /// response content.
    email_response_chunk_data: ?EmailResponseChunkDataDetails,
    /// Details about the generative chunk data.
    generative_chunk_data: ?GenerativeChunkDataDetails,
    /// Details about the generative data.
    generative_data: ?GenerativeDataDetails,
    /// Details about the intent data.
    intent_detected_data: ?IntentDetectedDataDetails,
    /// Details about notes chunk data.
    notes_chunk_data: ?NotesChunkDataDetails,
    /// Details about notes data.
    notes_data: ?NotesDataDetails,
    /// Details about the content data.
    source_content_data: ?SourceContentDataDetails,
    /// Details about suggested message data.
    suggested_message_data: ?SuggestedMessageDataDetails,

    pub const json_field_names = .{
        .case_summarization_chunk_data = "caseSummarizationChunkData",
        .content_data = "contentData",
        .email_generative_answer_chunk_data = "emailGenerativeAnswerChunkData",
        .email_overview_chunk_data = "emailOverviewChunkData",
        .email_response_chunk_data = "emailResponseChunkData",
        .generative_chunk_data = "generativeChunkData",
        .generative_data = "generativeData",
        .intent_detected_data = "intentDetectedData",
        .notes_chunk_data = "notesChunkData",
        .notes_data = "notesData",
        .source_content_data = "sourceContentData",
        .suggested_message_data = "suggestedMessageData",
    };
};

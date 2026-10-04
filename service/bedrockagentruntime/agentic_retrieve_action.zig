const AgenticRetrieveFullDocExpansionDetails = @import("agentic_retrieve_full_doc_expansion_details.zig").AgenticRetrieveFullDocExpansionDetails;
const AgenticRetrieveMemoryRetrieveDetails = @import("agentic_retrieve_memory_retrieve_details.zig").AgenticRetrieveMemoryRetrieveDetails;
const AgenticRetrieveActionDetails = @import("agentic_retrieve_action_details.zig").AgenticRetrieveActionDetails;

/// An action taken during agentic retrieval.
pub const AgenticRetrieveAction = struct {
    /// Details of a full document expansion action.
    full_document_expansion: ?AgenticRetrieveFullDocExpansionDetails = null,

    /// The details of a long-term memory retrieval that the agent chose to perform.
    memory_retrieve: ?AgenticRetrieveMemoryRetrieveDetails = null,

    /// Details of the retrieve action.
    retrieve: ?AgenticRetrieveActionDetails = null,

    pub const json_field_names = .{
        .full_document_expansion = "fullDocumentExpansion",
        .memory_retrieve = "memoryRetrieve",
        .retrieve = "retrieve",
    };
};

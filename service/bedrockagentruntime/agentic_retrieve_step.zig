const std = @import("std");

/// The step in the agentic retrieval process.
pub const AgenticRetrieveStep = enum {
    /// The planning phase of retrieval.
    planning,
    /// The retrieval phase where data is fetched.
    retrieval,
    /// A speculative retrieval phase for optimization.
    speculative_retrieval,
    /// The full document expansion phase.
    full_document_expansion,
    /// The phase that restores prior session history from AgentCore Memory
    /// short-term memory, before the agent begins work.
    session_history_load,

    pub const json_field_names = .{
        .planning = "Planning",
        .retrieval = "Retrieval",
        .speculative_retrieval = "SpeculativeRetrieval",
        .full_document_expansion = "FullDocumentExpansion",
        .session_history_load = "SessionHistoryLoad",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .planning => "Planning",
            .retrieval => "Retrieval",
            .speculative_retrieval => "SpeculativeRetrieval",
            .full_document_expansion => "FullDocumentExpansion",
            .session_history_load => "SessionHistoryLoad",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

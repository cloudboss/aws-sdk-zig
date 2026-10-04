const NlpStatus = @import("nlp_status.zig").NlpStatus;

/// The natural language processing (NLP) configuration for a data store.
pub const NlpConfiguration = struct {
    /// The status of the NLP configuration.
    status: ?NlpStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};

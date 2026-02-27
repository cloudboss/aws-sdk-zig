/// Specifies the text input specifications.
pub const TextInputSpecification = struct {
    /// Time for which a bot waits before re-prompting a customer for text input.
    start_timeout_ms: i32,

    pub const json_field_names = .{
        .start_timeout_ms = "startTimeoutMs",
    };
};

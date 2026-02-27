/// Configurations for streaming.
pub const StreamingConfigurations = struct {
    /// The guardrail interval to apply as response is generated. By default, the
    /// guardrail interval is set to 50 characters. If a larger interval is
    /// specified, the response will be generated in larger chunks with fewer
    /// `ApplyGuardrail` calls. The following examples show the response generated
    /// for *Hello, I am an agent* input string.
    ///
    /// **Example response in chunks: Interval set to 3 characters**
    ///
    /// `'Hel', 'lo, ','I am', ' an', ' Age', 'nt'`
    ///
    /// Each chunk has at least 3 characters except for the last chunk
    ///
    /// **Example response in chunks: Interval set to 20 or more characters**
    ///
    /// `Hello, I am an Agent`
    apply_guardrail_interval: ?i32,

    /// Specifies whether to enable streaming for the final response. This is set to
    /// `false` by default.
    stream_final_response: bool = false,

    pub const json_field_names = .{
        .apply_guardrail_interval = "applyGuardrailInterval",
        .stream_final_response = "streamFinalResponse",
    };
};

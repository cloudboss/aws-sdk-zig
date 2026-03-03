const Citation = @import("citation.zig").Citation;
const GuadrailAction = @import("guadrail_action.zig").GuadrailAction;
const RetrieveAndGenerateOutput = @import("retrieve_and_generate_output.zig").RetrieveAndGenerateOutput;

pub const RetrieveAndGenerateResponse = struct {
    /// A list of segments of the generated response that are based on sources in
    /// the knowledge base, alongside information about the sources.
    citations: ?[]const Citation = null,

    /// Specifies if there is a guardrail intervention in the response.
    guardrail_action: ?GuadrailAction = null,

    /// Contains the response generated from querying the knowledge base.
    output: RetrieveAndGenerateOutput,

    /// The unique identifier of the session. When you first make a
    /// `RetrieveAndGenerate` request, Amazon Bedrock automatically generates this
    /// value. You must reuse this value for all subsequent requests in the same
    /// conversational session. This value allows Amazon Bedrock to maintain context
    /// and knowledge from previous interactions. You can't explicitly set the
    /// `sessionId` yourself.
    session_id: []const u8,

    pub const json_field_names = .{
        .citations = "citations",
        .guardrail_action = "guardrailAction",
        .output = "output",
        .session_id = "sessionId",
    };
};

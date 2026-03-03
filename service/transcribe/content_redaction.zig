const PiiEntityType = @import("pii_entity_type.zig").PiiEntityType;
const RedactionOutput = @import("redaction_output.zig").RedactionOutput;
const RedactionType = @import("redaction_type.zig").RedactionType;

/// Makes it possible to redact or flag specified personally identifiable
/// information (PII) in
/// your transcript. If you use `ContentRedaction`, you must also include the
/// sub-parameters: `RedactionOutput` and `RedactionType`. You can
/// optionally include `PiiEntityTypes` to choose which types of PII you want to
/// redact.
pub const ContentRedaction = struct {
    /// Specify which types of personally identifiable information (PII) you want to
    /// redact in
    /// your transcript. You can include as many types as you'd like, or you can
    /// select
    /// `ALL`. If you do not include `PiiEntityTypes` in your request, all PII is
    /// redacted.
    pii_entity_types: ?[]const PiiEntityType = null,

    /// Specify if you want only a redacted transcript, or if you want a redacted
    /// and an
    /// unredacted transcript.
    ///
    /// When you choose `redacted`
    /// Amazon Transcribe creates only a redacted transcript.
    ///
    /// When you choose `redacted_and_unredacted`
    /// Amazon Transcribe creates a redacted and an unredacted transcript (as two
    /// separate
    /// files).
    redaction_output: RedactionOutput,

    /// Specify the category of information you want to redact; `PII` (personally
    /// identifiable information) is the only valid value. You can use
    /// `PiiEntityTypes` to
    /// choose which types of PII you want to redact. If you do not include
    /// `PiiEntityTypes` in
    /// your request, all PII is redacted.
    redaction_type: RedactionType,

    pub const json_field_names = .{
        .pii_entity_types = "PiiEntityTypes",
        .redaction_output = "RedactionOutput",
        .redaction_type = "RedactionType",
    };
};

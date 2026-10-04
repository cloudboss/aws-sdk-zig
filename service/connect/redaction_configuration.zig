const Behavior = @import("behavior.zig").Behavior;
const MaskMode = @import("mask_mode.zig").MaskMode;
const Policy = @import("policy.zig").Policy;

/// The redaction configuration for conversational analytics.
pub const RedactionConfiguration = struct {
    /// Controls whether redaction is applied to the analytics output. Valid values:
    /// `Enable` |
    /// `Disable`.
    behavior: Behavior,

    /// The list of PII entity types to redact from the transcript (for example,
    /// `NAME`,
    /// `ADDRESS`, `CREDIT_DEBIT_NUMBER`).
    entities: ?[]const []const u8 = null,

    /// The masking mode that determines how redacted content is replaced in the
    /// output. Valid values:
    /// `PII` (replaces with the literal string [PII]) | `EntityType` (replaces with
    /// the
    /// entity type name, for example [NAME]).
    mask_mode: ?MaskMode = null,

    /// The redaction output policy that determines which versions of the transcript
    /// are stored. Valid values:
    /// `None` | `RedactedOnly` | `RedactedAndOriginal`.
    policy: Policy,

    pub const json_field_names = .{
        .behavior = "Behavior",
        .entities = "Entities",
        .mask_mode = "MaskMode",
        .policy = "Policy",
    };
};

const ValidationFindingCode = @import("validation_finding_code.zig").ValidationFindingCode;
const ValidationFindingScope = @import("validation_finding_scope.zig").ValidationFindingScope;
const ValidationFindingType = @import("validation_finding_type.zig").ValidationFindingType;

/// A validation finding from a cloud connector validation check.
pub const ValidationFinding = struct {
    /// A code that identifies the specific validation finding.
    code: ?ValidationFindingCode = null,

    /// A message that describes the validation finding.
    message: ?[]const u8 = null,

    /// A message from the third-party cloud provider related to the validation
    /// finding.
    provider_message: ?[]const u8 = null,

    /// The scope of the validation finding, identifying the specific resource
    /// affected.
    scope: ?ValidationFindingScope = null,

    /// The type of the validation finding.
    type: ?ValidationFindingType = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .provider_message = "ProviderMessage",
        .scope = "Scope",
        .type = "Type",
    };
};

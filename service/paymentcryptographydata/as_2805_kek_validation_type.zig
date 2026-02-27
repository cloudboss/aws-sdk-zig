const KekValidationRequest = @import("kek_validation_request.zig").KekValidationRequest;
const KekValidationResponse = @import("kek_validation_response.zig").KekValidationResponse;

/// Parameter information for generating a random key for KEK validation to
/// perform node-to-node initialization.
pub const As2805KekValidationType = union(enum) {
    /// Parameter information for generating a KEK validation request during
    /// node-to-node initialization.
    kek_validation_request: ?KekValidationRequest,
    /// Parameter information for generating a KEK validation response during
    /// node-to-node initialization.
    kek_validation_response: ?KekValidationResponse,

    pub const json_field_names = .{
        .kek_validation_request = "KekValidationRequest",
        .kek_validation_response = "KekValidationResponse",
    };
};

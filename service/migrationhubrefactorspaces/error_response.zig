const aws = @import("aws");

const ErrorCode = @import("error_code.zig").ErrorCode;
const ErrorResourceType = @import("error_resource_type.zig").ErrorResourceType;

/// Error associated with a resource returned for a Get or List resource
/// response.
pub const ErrorResponse = struct {
    /// The Amazon Web Services account ID of the resource owner.
    account_id: ?[]const u8,

    /// Additional details about the error.
    additional_details: ?[]const aws.map.StringMapEntry,

    /// The error code associated with the error.
    code: ?ErrorCode,

    /// The message associated with the error.
    message: ?[]const u8,

    /// The ID of the resource.
    resource_identifier: ?[]const u8,

    /// The type of resource.
    resource_type: ?ErrorResourceType,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .additional_details = "AdditionalDetails",
        .code = "Code",
        .message = "Message",
        .resource_identifier = "ResourceIdentifier",
        .resource_type = "ResourceType",
    };
};

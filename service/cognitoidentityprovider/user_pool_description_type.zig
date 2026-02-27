const LambdaConfigType = @import("lambda_config_type.zig").LambdaConfigType;
const StatusType = @import("status_type.zig").StatusType;

/// A short description of a user pool.
pub const UserPoolDescriptionType = struct {
    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: ?i64,

    /// The user pool ID.
    id: ?[]const u8,

    /// A collection of user pool Lambda triggers. Amazon Cognito invokes triggers
    /// at several possible
    /// stages of user pool operations. Triggers can modify the outcome of the
    /// operations that
    /// invoked them.
    lambda_config: ?LambdaConfigType,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    last_modified_date: ?i64,

    /// The user pool name.
    name: ?[]const u8,

    /// The user pool status.
    status: ?StatusType,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .id = "Id",
        .lambda_config = "LambdaConfig",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .status = "Status",
    };
};

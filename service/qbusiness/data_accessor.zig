const DataAccessorAuthenticationDetail = @import("data_accessor_authentication_detail.zig").DataAccessorAuthenticationDetail;

/// Provides summary information about a data accessor.
pub const DataAccessor = struct {
    /// The authentication configuration details for the data accessor. This
    /// specifies how the ISV authenticates when accessing data through this data
    /// accessor.
    authentication_detail: ?DataAccessorAuthenticationDetail = null,

    /// The timestamp when the data accessor was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the data accessor.
    data_accessor_arn: ?[]const u8 = null,

    /// The unique identifier of the data accessor.
    data_accessor_id: ?[]const u8 = null,

    /// The friendly name of the data accessor.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the associated IAM Identity Center
    /// application.
    idc_application_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role for the ISV associated with
    /// this data accessor.
    principal: ?[]const u8 = null,

    /// The timestamp when the data accessor was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .authentication_detail = "authenticationDetail",
        .created_at = "createdAt",
        .data_accessor_arn = "dataAccessorArn",
        .data_accessor_id = "dataAccessorId",
        .display_name = "displayName",
        .idc_application_arn = "idcApplicationArn",
        .principal = "principal",
        .updated_at = "updatedAt",
    };
};

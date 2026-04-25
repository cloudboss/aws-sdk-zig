const AccessEndpoint = @import("access_endpoint.zig").AccessEndpoint;
const ResourceError = @import("resource_error.zig").ResourceError;
const AppBlockBuilderPlatformType = @import("app_block_builder_platform_type.zig").AppBlockBuilderPlatformType;
const AppBlockBuilderState = @import("app_block_builder_state.zig").AppBlockBuilderState;
const AppBlockBuilderStateChangeReason = @import("app_block_builder_state_change_reason.zig").AppBlockBuilderStateChangeReason;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Describes an app block builder.
pub const AppBlockBuilder = struct {
    /// The list of interface VPC endpoint (interface endpoint) objects.
    /// Administrators can connect to the app block builder only through the
    /// specified endpoints.
    access_endpoints: ?[]const AccessEndpoint = null,

    /// The app block builder errors.
    app_block_builder_errors: ?[]const ResourceError = null,

    /// The ARN of the app block builder.
    arn: []const u8,

    /// The creation time of the app block builder.
    created_time: ?i64 = null,

    /// The description of the app block builder.
    description: ?[]const u8 = null,

    /// Indicates whether Instance Metadata Service Version 1 (IMDSv1) is disabled
    /// for the app block builder.
    disable_imdsv1: ?bool = null,

    /// The display name of the app block builder.
    display_name: ?[]const u8 = null,

    /// Indicates whether default internet access is enabled for the app block
    /// builder.
    enable_default_internet_access: ?bool = null,

    /// The ARN of the IAM role that is applied to the app block builder.
    iam_role_arn: ?[]const u8 = null,

    /// The instance type of the app block builder.
    instance_type: []const u8,

    /// The name of the app block builder.
    name: []const u8,

    /// The platform of the app block builder.
    ///
    /// `WINDOWS_SERVER_2019` is the only valid value.
    platform: AppBlockBuilderPlatformType,

    /// The state of the app block builder.
    state: AppBlockBuilderState,

    /// The state change reason.
    state_change_reason: ?AppBlockBuilderStateChangeReason = null,

    /// The VPC configuration for the app block builder.
    vpc_config: VpcConfig,

    pub const json_field_names = .{
        .access_endpoints = "AccessEndpoints",
        .app_block_builder_errors = "AppBlockBuilderErrors",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .disable_imdsv1 = "DisableIMDSV1",
        .display_name = "DisplayName",
        .enable_default_internet_access = "EnableDefaultInternetAccess",
        .iam_role_arn = "IamRoleArn",
        .instance_type = "InstanceType",
        .name = "Name",
        .platform = "Platform",
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .vpc_config = "VpcConfig",
    };
};

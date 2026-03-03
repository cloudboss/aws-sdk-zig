const ErrorDetails = @import("error_details.zig").ErrorDetails;
const PackagingType = @import("packaging_type.zig").PackagingType;
const ScriptDetails = @import("script_details.zig").ScriptDetails;
const S3Location = @import("s3_location.zig").S3Location;
const AppBlockState = @import("app_block_state.zig").AppBlockState;

/// Describes an app block.
///
/// App blocks are a WorkSpaces Applications resource that stores the details
/// about the
/// virtual hard disk in an S3 bucket. It also stores the setup script with
/// details about
/// how to mount the virtual hard disk. The virtual hard disk includes the
/// application
/// binaries and other files necessary to launch your applications. Multiple
/// applications
/// can be assigned to a single app block.
///
/// This is only supported for Elastic fleets.
pub const AppBlock = struct {
    /// The errors of the app block.
    app_block_errors: ?[]const ErrorDetails = null,

    /// The ARN of the app block.
    arn: []const u8,

    /// The created time of the app block.
    created_time: ?i64 = null,

    /// The description of the app block.
    description: ?[]const u8 = null,

    /// The display name of the app block.
    display_name: ?[]const u8 = null,

    /// The name of the app block.
    name: []const u8,

    /// The packaging type of the app block.
    packaging_type: ?PackagingType = null,

    /// The post setup script details of the app block.
    ///
    /// This only applies to app blocks with PackagingType `APPSTREAM2`.
    post_setup_script_details: ?ScriptDetails = null,

    /// The setup script details of the app block.
    ///
    /// This only applies to app blocks with PackagingType `CUSTOM`.
    setup_script_details: ?ScriptDetails = null,

    /// The source S3 location of the app block.
    source_s3_location: ?S3Location = null,

    /// The state of the app block.
    ///
    /// An app block with WorkSpaces Applications packaging will be in the
    /// `INACTIVE` state
    /// if no application package (VHD) is assigned to it. After an application
    /// package (VHD) is
    /// created by an app block builder for an app block, it becomes `ACTIVE`.
    ///
    /// Custom app blocks are always in the `ACTIVE` state and no action is required
    /// to use them.
    state: ?AppBlockState = null,

    pub const json_field_names = .{
        .app_block_errors = "AppBlockErrors",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .display_name = "DisplayName",
        .name = "Name",
        .packaging_type = "PackagingType",
        .post_setup_script_details = "PostSetupScriptDetails",
        .setup_script_details = "SetupScriptDetails",
        .source_s3_location = "SourceS3Location",
        .state = "State",
    };
};

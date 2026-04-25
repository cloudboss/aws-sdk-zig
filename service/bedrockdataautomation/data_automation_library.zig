const aws = @import("aws");

const EntityTypeInfo = @import("entity_type_info.zig").EntityTypeInfo;
const DataAutomationLibraryStatus = @import("data_automation_library_status.zig").DataAutomationLibraryStatus;

/// Contains the information of a DataAutomationLibrary.
pub const DataAutomationLibrary = struct {
    creation_time: i64,

    entity_types: ?[]const EntityTypeInfo = null,

    kms_encryption_context: ?[]const aws.map.StringMapEntry = null,

    kms_key_id: ?[]const u8 = null,

    library_arn: []const u8,

    library_description: ?[]const u8 = null,

    library_name: []const u8,

    status: DataAutomationLibraryStatus,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .entity_types = "entityTypes",
        .kms_encryption_context = "kmsEncryptionContext",
        .kms_key_id = "kmsKeyId",
        .library_arn = "libraryArn",
        .library_description = "libraryDescription",
        .library_name = "libraryName",
        .status = "status",
    };
};

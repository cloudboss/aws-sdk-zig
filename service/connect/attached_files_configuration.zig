const AttachmentScope = @import("attachment_scope.zig").AttachmentScope;
const ExtensionConfiguration = @import("extension_configuration.zig").ExtensionConfiguration;

/// The configuration for attached files for a specific attachment scope.
pub const AttachedFilesConfiguration = struct {
    /// The scope of the attachment. Valid values are `EMAIL`, `CHAT`, `CASE`, and
    /// `TASK`.
    attachment_scope: AttachmentScope,

    /// The configuration for allowed file extensions.
    extension_configuration: ?ExtensionConfiguration = null,

    /// The identifier of the Amazon Connect instance.
    instance_id: []const u8,

    /// The timestamp when the configuration was last modified.
    last_modified_time: ?i64 = null,

    /// The maximum size limit for attached files in bytes.
    maximum_size_limit_in_bytes: ?i64 = null,

    pub const json_field_names = .{
        .attachment_scope = "AttachmentScope",
        .extension_configuration = "ExtensionConfiguration",
        .instance_id = "InstanceId",
        .last_modified_time = "LastModifiedTime",
        .maximum_size_limit_in_bytes = "MaximumSizeLimitInBytes",
    };
};

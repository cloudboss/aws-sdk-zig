const SchemaExtensionStatus = @import("schema_extension_status.zig").SchemaExtensionStatus;

/// Information about a schema extension.
pub const SchemaExtensionInfo = struct {
    /// A description of the schema extension.
    description: ?[]const u8 = null,

    /// The identifier of the directory to which the schema extension is applied.
    directory_id: ?[]const u8 = null,

    /// The date and time that the schema extension was completed.
    end_date_time: ?i64 = null,

    /// The identifier of the schema extension.
    schema_extension_id: ?[]const u8 = null,

    /// The current status of the schema extension.
    schema_extension_status: ?SchemaExtensionStatus = null,

    /// The reason for the `SchemaExtensionStatus`.
    schema_extension_status_reason: ?[]const u8 = null,

    /// The date and time that the schema extension started being applied to the
    /// directory.
    start_date_time: ?i64 = null,

    pub const json_field_names = .{
        .description = "Description",
        .directory_id = "DirectoryId",
        .end_date_time = "EndDateTime",
        .schema_extension_id = "SchemaExtensionId",
        .schema_extension_status = "SchemaExtensionStatus",
        .schema_extension_status_reason = "SchemaExtensionStatusReason",
        .start_date_time = "StartDateTime",
    };
};

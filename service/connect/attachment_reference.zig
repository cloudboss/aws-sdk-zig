const ReferenceStatus = @import("reference_status.zig").ReferenceStatus;

/// Information about a reference when the `referenceType` is `ATTACHMENT`.
/// Otherwise,
/// null.
pub const AttachmentReference = struct {
    /// The Amazon Resource Name (ARN) of the attachment reference.
    arn: ?[]const u8,

    /// Identifier of the attachment reference.
    name: ?[]const u8,

    /// Status of the attachment reference type.
    status: ?ReferenceStatus,

    /// The location path of the attachment reference.
    value: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .status = "Status",
        .value = "Value",
    };
};

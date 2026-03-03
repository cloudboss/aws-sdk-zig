const ReferenceStatus = @import("reference_status.zig").ReferenceStatus;

/// Information about a reference when the `referenceType` is `ATTACHMENT`.
/// Otherwise,
/// null.
pub const AttachmentReference = struct {
    /// The Amazon Resource Name (ARN) of the attachment reference.
    arn: ?[]const u8 = null,

    /// Identifier of the attachment reference.
    name: ?[]const u8 = null,

    /// Status of the attachment reference type.
    status: ?ReferenceStatus = null,

    /// The location path of the attachment reference.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .status = "Status",
        .value = "Value",
    };
};

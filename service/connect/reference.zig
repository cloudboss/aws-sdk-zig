const ReferenceStatus = @import("reference_status.zig").ReferenceStatus;
const ReferenceType = @import("reference_type.zig").ReferenceType;

/// Well-formed data on a contact, used by agents to complete a contact request.
/// You can have up to 4,096 UTF-8
/// bytes across all references for a contact.
pub const Reference = struct {
    /// The Amazon Resource Name (ARN) of the reference
    arn: ?[]const u8,

    /// Status of the attachment reference type.
    status: ?ReferenceStatus,

    /// Relevant details why the reference was not successfully created.
    status_reason: ?[]const u8,

    /// The type of the reference. `DATE` must be of type Epoch timestamp.
    type: ReferenceType,

    /// A valid value for the reference. For example, for a URL reference, a
    /// formatted URL that is displayed to an agent
    /// in the Contact Control Panel (CCP).
    value: []const u8 = "",

    pub const json_field_names = .{
        .arn = "Arn",
        .status = "Status",
        .status_reason = "StatusReason",
        .type = "Type",
        .value = "Value",
    };
};

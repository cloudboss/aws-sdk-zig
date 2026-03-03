const CreateAssociationBatchRequestEntry = @import("create_association_batch_request_entry.zig").CreateAssociationBatchRequestEntry;
const Fault = @import("fault.zig").Fault;

/// Describes a failed association.
pub const FailedCreateAssociation = struct {
    /// The association.
    entry: ?CreateAssociationBatchRequestEntry = null,

    /// The source of the failure.
    fault: ?Fault = null,

    /// A description of the failure.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .entry = "Entry",
        .fault = "Fault",
        .message = "Message",
    };
};

const AssociationStatusCode = @import("association_status_code.zig").AssociationStatusCode;

/// Describes the state of a target network association.
pub const AssociationStatus = struct {
    /// The state of the target network association.
    code: ?AssociationStatusCode,

    /// A message about the status of the target network association, if applicable.
    message: ?[]const u8,
};

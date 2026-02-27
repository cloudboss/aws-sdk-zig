const UserStackAssociationErrorCode = @import("user_stack_association_error_code.zig").UserStackAssociationErrorCode;
const UserStackAssociation = @import("user_stack_association.zig").UserStackAssociation;

/// Describes the error that is returned when a user can’t be associated with or
/// disassociated from a stack.
pub const UserStackAssociationError = struct {
    /// The error code for the error that is returned when a user can’t be
    /// associated with or disassociated from a stack.
    error_code: ?UserStackAssociationErrorCode,

    /// The error message for the error that is returned when a user can’t be
    /// associated with or disassociated from a stack.
    error_message: ?[]const u8,

    /// Information about the user and associated stack.
    user_stack_association: ?UserStackAssociation,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .user_stack_association = "UserStackAssociation",
    };
};

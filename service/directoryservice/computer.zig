const Attribute = @import("attribute.zig").Attribute;

/// Contains information about a computer account in a directory.
pub const Computer = struct {
    /// An array of Attribute objects containing the LDAP attributes that belong to
    /// the
    /// computer account.
    computer_attributes: ?[]const Attribute,

    /// The identifier of the computer.
    computer_id: ?[]const u8,

    /// The computer name.
    computer_name: ?[]const u8,

    pub const json_field_names = .{
        .computer_attributes = "ComputerAttributes",
        .computer_id = "ComputerId",
        .computer_name = "ComputerName",
    };
};

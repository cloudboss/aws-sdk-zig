/// Components that correspond to secondary identifiers on an address. The only
/// component type supported currently is Unit.
pub const SecondaryAddressComponent = struct {
    /// The designator of the secondary address component.
    ///
    /// Example: `Apt`.
    designator: ?[]const u8 = null,

    /// Number that uniquely identifies a secondary address.
    number: []const u8,

    pub const json_field_names = .{
        .designator = "Designator",
        .number = "Number",
    };
};

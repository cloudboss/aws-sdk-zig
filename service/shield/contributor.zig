/// A contributor to the attack and their contribution.
pub const Contributor = struct {
    /// The name of the contributor. The type of name that you'll find here depends
    /// on the `AttackPropertyIdentifier` setting in the `AttackProperty` where this
    /// contributor is defined. For example, if the `AttackPropertyIdentifier` is
    /// `SOURCE_COUNTRY`, the `Name` could be `United States`.
    name: ?[]const u8,

    /// The contribution of this contributor expressed in Protection units. For
    /// example `10,000`.
    value: i64 = 0,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};

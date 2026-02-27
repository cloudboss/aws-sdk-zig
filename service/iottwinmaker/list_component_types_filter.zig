/// An object that filters items in a list of component types.
///
/// Only one object is accepted as a valid input.
pub const ListComponentTypesFilter = union(enum) {
    /// The component type that the component types in the list extend.
    extends_from: ?[]const u8,
    /// A Boolean value that specifies whether the component types in the list are
    /// abstract.
    is_abstract: ?bool,
    /// The namespace to which the component types in the list belong.
    namespace: ?[]const u8,

    pub const json_field_names = .{
        .extends_from = "extendsFrom",
        .is_abstract = "isAbstract",
        .namespace = "namespace",
    };
};

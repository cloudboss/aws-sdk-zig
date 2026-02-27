/// The high-level entity that can be queried in Amazon AppFlow. For example, a
/// Salesforce entity might be an *Account* or
/// *Opportunity*, whereas a ServiceNow entity might be an
/// *Incident*.
pub const ConnectorEntity = struct {
    /// Specifies whether the connector entity is a parent or a category and has
    /// more entities
    /// nested underneath it. If another call is made with `entitiesPath =
    /// "the_current_entity_name_with_hasNestedEntities_true"`, then it returns the
    /// nested
    /// entities underneath it. This provides a way to retrieve all supported
    /// entities in a recursive
    /// fashion.
    has_nested_entities: bool = false,

    /// The label applied to the connector entity.
    label: ?[]const u8,

    /// The name of the connector entity.
    name: []const u8,

    pub const json_field_names = .{
        .has_nested_entities = "hasNestedEntities",
        .label = "label",
        .name = "name",
    };
};

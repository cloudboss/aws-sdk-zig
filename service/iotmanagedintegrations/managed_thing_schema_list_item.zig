/// Structure representing one schema item associated with a managed thing.
pub const ManagedThingSchemaListItem = struct {
    /// The id of the capability for a managed thing.
    capability_id: ?[]const u8 = null,

    /// The id of the endpoint for a managed thing.
    endpoint_id: ?[]const u8 = null,

    /// The validation schema for one schema item associated with a managed thing.
    schema: ?[]const u8 = null,

    pub const json_field_names = .{
        .capability_id = "CapabilityId",
        .endpoint_id = "EndpointId",
        .schema = "Schema",
    };
};

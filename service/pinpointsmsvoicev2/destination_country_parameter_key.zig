pub const DestinationCountryParameterKey = enum {
    in_template_id,
    in_entity_id,

    pub const json_field_names = .{
        .in_template_id = "IN_TEMPLATE_ID",
        .in_entity_id = "IN_ENTITY_ID",
    };
};

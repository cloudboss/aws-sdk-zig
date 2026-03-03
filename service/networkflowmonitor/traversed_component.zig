/// A section of the network that a network flow has traveled through.
pub const TraversedComponent = struct {
    /// The Amazon Resource Name (ARN) of a traversed component.
    component_arn: ?[]const u8 = null,

    /// The identifier for the traversed component.
    component_id: ?[]const u8 = null,

    /// The type of component that was traversed.
    component_type: ?[]const u8 = null,

    /// The service name for the traversed component.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .component_arn = "componentArn",
        .component_id = "componentId",
        .component_type = "componentType",
        .service_name = "serviceName",
    };
};

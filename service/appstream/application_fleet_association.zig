/// Describes the application fleet association.
pub const ApplicationFleetAssociation = struct {
    /// The ARN of the application associated with the fleet.
    application_arn: []const u8,

    /// The name of the fleet associated with the application.
    fleet_name: []const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .fleet_name = "FleetName",
    };
};

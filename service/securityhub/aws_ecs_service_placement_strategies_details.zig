/// A placement strategy that determines how to place the tasks for the service.
pub const AwsEcsServicePlacementStrategiesDetails = struct {
    /// The field to apply the placement strategy against.
    ///
    /// For the `spread` placement strategy, valid values are `instanceId` (or
    /// `host`, which has the same effect), or any platform or custom attribute that
    /// is applied to a container instance, such as
    /// `attribute:ecs.availability-zone`.
    ///
    /// For the `binpack` placement strategy, valid values are `cpu` and `memory`.
    ///
    /// For the `random` placement strategy, this attribute is not used.
    field: ?[]const u8 = null,

    /// The type of placement strategy.
    ///
    /// The `random` placement strategy randomly places tasks on available
    /// candidates.
    ///
    /// The `spread` placement strategy spreads placement across available
    /// candidates evenly based on the value of `Field`.
    ///
    /// The `binpack` strategy places tasks on available candidates that have the
    /// least available amount of the resource that is specified in `Field`.
    ///
    /// Valid values: `random` | `spread` | `binpack`
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .field = "Field",
        .@"type" = "Type",
    };
};

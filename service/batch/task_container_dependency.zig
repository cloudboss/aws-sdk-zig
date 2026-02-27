/// A list of containers that this task depends on.
pub const TaskContainerDependency = struct {
    /// The dependency condition of the container. The following are the available
    /// conditions and
    /// their behavior:
    ///
    /// * `START` - This condition emulates the behavior of links and volumes today.
    ///   It
    /// validates that a dependent container is started before permitting other
    /// containers to start.
    ///
    /// * `COMPLETE` - This condition validates that a dependent container runs to
    /// completion (exits) before permitting other containers to start. This can be
    /// useful for
    /// nonessential containers that run a script and then exit. This condition
    /// can't be set on an
    /// essential container.
    ///
    /// * `SUCCESS` - This condition is the same as `COMPLETE`, but it also
    /// requires that the container exits with a zero status. This condition can't
    /// be set on an
    /// essential container.
    condition: ?[]const u8,

    /// A unique identifier for the container.
    container_name: ?[]const u8,

    pub const json_field_names = .{
        .condition = "condition",
        .container_name = "containerName",
    };
};

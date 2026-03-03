/// Defines the stairs traffic pattern for an Inference Recommender load test.
/// This pattern type consists of multiple steps where the number of users
/// increases at each step.
///
/// Specify either the stairs or phases traffic pattern.
pub const Stairs = struct {
    /// Defines how long each traffic step should be.
    duration_in_seconds: ?i32 = null,

    /// Specifies how many steps to perform during traffic.
    number_of_steps: ?i32 = null,

    /// Specifies how many new users to spawn in each step.
    users_per_step: ?i32 = null,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
        .number_of_steps = "NumberOfSteps",
        .users_per_step = "UsersPerStep",
    };
};

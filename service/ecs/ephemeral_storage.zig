/// The amount of ephemeral storage to allocate for the task. This parameter is
/// used to
/// expand the total amount of ephemeral storage available, beyond the default
/// amount, for
/// tasks hosted on Fargate. For more information, see [Using data volumes in
/// tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_data_volumes.html) in the *Amazon ECS Developer Guide;*.
///
/// For tasks using the Fargate launch type, the task requires the following
/// platforms:
///
/// * Linux platform version `1.4.0` or later.
///
/// * Windows platform version `1.0.0` or later.
pub const EphemeralStorage = struct {
    /// The total amount, in GiB, of ephemeral storage to set for the task. The
    /// minimum
    /// supported value is `21` GiB and the maximum supported value is
    /// `200` GiB.
    size_in_gi_b: i32 = 0,

    pub const json_field_names = .{
        .size_in_gi_b = "sizeInGiB",
    };
};

const QualificationTypeStatus = @import("qualification_type_status.zig").QualificationTypeStatus;

/// The QualificationType data structure represents a
/// Qualification type, a description of a property of a Worker that must
/// match the requirements of a HIT for the Worker to be able to accept
/// the HIT. The type also describes how a Worker can obtain a
/// Qualification of that type, such as through a Qualification test.
pub const QualificationType = struct {
    /// The answers to the Qualification test specified in the Test
    /// parameter.
    answer_key: ?[]const u8,

    /// Specifies that requests for the Qualification type are
    /// granted immediately, without prompting the Worker with a
    /// Qualification test. Valid values are True | False.
    auto_granted: ?bool,

    /// The Qualification integer value to use for automatically
    /// granted Qualifications, if AutoGranted is true. This is 1 by default.
    auto_granted_value: ?i32,

    /// The date and time the Qualification type was created.
    creation_time: ?i64,

    /// A long description for the Qualification type.
    description: ?[]const u8,

    /// Specifies whether the Qualification type is one that a user
    /// can request through the Amazon Mechanical Turk web site, such as by
    /// taking a Qualification test. This value is False for Qualifications
    /// assigned automatically by the system. Valid values are True | False.
    is_requestable: ?bool,

    /// One or more words or phrases that describe theQualification
    /// type, separated by commas. The Keywords make the type easier to find
    /// using a search.
    keywords: ?[]const u8,

    /// The name of the Qualification type. The type name is used to
    /// identify the type, and to find the type using a Qualification type
    /// search.
    name: ?[]const u8,

    /// A unique identifier for the Qualification type. A
    /// Qualification type is given a Qualification type ID when you call the
    /// CreateQualificationType operation.
    qualification_type_id: ?[]const u8,

    /// The status of the Qualification type. A Qualification type's
    /// status determines if users can apply to receive a Qualification of
    /// this type, and if HITs can be created with requirements based on this
    /// type. Valid values are Active | Inactive.
    qualification_type_status: ?QualificationTypeStatus,

    /// The amount of time, in seconds, Workers must wait after
    /// taking the Qualification test before they can take it again. Workers
    /// can take a Qualification test multiple times if they were not granted
    /// the Qualification from a previous attempt, or if the test offers a
    /// gradient score and they want a better score. If not specified,
    /// retries are disabled and Workers can request a Qualification only
    /// once.
    retry_delay_in_seconds: ?i64,

    /// The questions for a Qualification test associated with this
    /// Qualification type that a user can take to obtain a Qualification of
    /// this type. This parameter must be specified if AnswerKey is present.
    /// A Qualification type cannot have both a specified Test parameter and
    /// an AutoGranted value of true.
    @"test": ?[]const u8,

    /// The amount of time, in seconds, given to a Worker to
    /// complete the Qualification test, beginning from the time the Worker
    /// requests the Qualification.
    test_duration_in_seconds: ?i64,

    pub const json_field_names = .{
        .answer_key = "AnswerKey",
        .auto_granted = "AutoGranted",
        .auto_granted_value = "AutoGrantedValue",
        .creation_time = "CreationTime",
        .description = "Description",
        .is_requestable = "IsRequestable",
        .keywords = "Keywords",
        .name = "Name",
        .qualification_type_id = "QualificationTypeId",
        .qualification_type_status = "QualificationTypeStatus",
        .retry_delay_in_seconds = "RetryDelayInSeconds",
        .@"test" = "Test",
        .test_duration_in_seconds = "TestDurationInSeconds",
    };
};

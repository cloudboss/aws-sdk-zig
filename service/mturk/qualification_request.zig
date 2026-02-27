/// The QualificationRequest data structure represents a request
/// a Worker has made for a Qualification.
pub const QualificationRequest = struct {
    /// The Worker's answers for the Qualification type's test
    /// contained in a QuestionFormAnswers document, if the type has a test
    /// and the Worker has submitted answers. If the Worker does not provide
    /// any answers, Answer may be empty.
    answer: ?[]const u8,

    /// The ID of the Qualification request, a unique identifier
    /// generated when the request was submitted.
    qualification_request_id: ?[]const u8,

    /// The ID of the Qualification type the Worker is requesting,
    /// as returned by the CreateQualificationType operation.
    qualification_type_id: ?[]const u8,

    /// The date and time the Qualification request had a status of
    /// Submitted. This is either the time the Worker submitted answers for a
    /// Qualification test, or the time the Worker requested the
    /// Qualification if the Qualification type does not have a test.
    submit_time: ?i64,

    /// The contents of the Qualification test that was presented to
    /// the Worker, if the type has a test and the Worker has submitted
    /// answers. This value is identical to the QuestionForm associated with
    /// the Qualification type at the time the Worker requests the
    /// Qualification.
    @"test": ?[]const u8,

    /// The ID of the Worker requesting the Qualification.
    worker_id: ?[]const u8,

    pub const json_field_names = .{
        .answer = "Answer",
        .qualification_request_id = "QualificationRequestId",
        .qualification_type_id = "QualificationTypeId",
        .submit_time = "SubmitTime",
        .@"test" = "Test",
        .worker_id = "WorkerId",
    };
};

pub const ProcessingS3UploadMode = enum {
    continuous,
    end_of_job,

    pub const json_field_names = .{
        .continuous = "CONTINUOUS",
        .end_of_job = "END_OF_JOB",
    };
};

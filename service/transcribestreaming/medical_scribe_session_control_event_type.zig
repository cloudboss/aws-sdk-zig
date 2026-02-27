pub const MedicalScribeSessionControlEventType = enum {
    end_of_session,

    pub const json_field_names = .{
        .end_of_session = "END_OF_SESSION",
    };
};

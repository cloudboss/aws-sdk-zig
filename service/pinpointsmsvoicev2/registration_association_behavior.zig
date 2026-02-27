pub const RegistrationAssociationBehavior = enum {
    associate_before_submit,
    associate_on_approval,
    associate_after_complete,

    pub const json_field_names = .{
        .associate_before_submit = "ASSOCIATE_BEFORE_SUBMIT",
        .associate_on_approval = "ASSOCIATE_ON_APPROVAL",
        .associate_after_complete = "ASSOCIATE_AFTER_COMPLETE",
    };
};

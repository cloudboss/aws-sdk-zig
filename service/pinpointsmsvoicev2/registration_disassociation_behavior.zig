pub const RegistrationDisassociationBehavior = enum {
    disassociate_all_closes_registration,
    disassociate_all_allows_delete_registration,
    delete_registration_disassociates,

    pub const json_field_names = .{
        .disassociate_all_closes_registration = "DISASSOCIATE_ALL_CLOSES_REGISTRATION",
        .disassociate_all_allows_delete_registration = "DISASSOCIATE_ALL_ALLOWS_DELETE_REGISTRATION",
        .delete_registration_disassociates = "DELETE_REGISTRATION_DISASSOCIATES",
    };
};

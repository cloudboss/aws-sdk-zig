pub const ChangeSource = enum {
    resource_reference,
    parameter_reference,
    resource_attribute,
    direct_modification,
    automatic,
    no_modification,
};

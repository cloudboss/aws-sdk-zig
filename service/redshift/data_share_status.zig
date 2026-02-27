pub const DataShareStatus = enum {
    active,
    pending_authorization,
    authorized,
    deauthorized,
    rejected,
    available,
};

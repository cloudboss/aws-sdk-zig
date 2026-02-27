/// The mode for creating a ticket.
pub const TicketCreationMode = enum {
    dryrun,

    pub const json_field_names = .{
        .dryrun = "DRYRUN",
    };
};

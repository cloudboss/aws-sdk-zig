pub const Format = enum {
    csv,
    opencypher,
    ntriples,
    nquads,
    rdfxml,
    turtle,

    pub const json_field_names = .{
        .csv = "CSV",
        .opencypher = "OPENCYPHER",
        .ntriples = "NTRIPLES",
        .nquads = "NQUADS",
        .rdfxml = "RDFXML",
        .turtle = "TURTLE",
    };
};

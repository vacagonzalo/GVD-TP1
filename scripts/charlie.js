config = {
    _id: 'charlie', members: [
        {_id: 0, host: 'charlie01'},
        {_id: 1, host: 'charlie02'},
        {_id: 2, host: 'charlie03'}
    ]
};
rs.initiate(config);
rs.status();
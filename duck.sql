create or replace temp table load_stages_projets_tutores as
    select * from 'data/stages_opt_unc.csv';

create or replace table stages_projets_tutores(
    date_soutenance date not null,
    project_type varchar not null check (project_type in ('PROJET_TUTORE', 'STAGE')),
    uo varchar not null check (uo like 'DSI/%'),
    sujet varchar not null,
    description varchar,
    etudiants varchar not null,
    url_git varchar check (url_git is null or url_git like 'https://github.com/%'),
    url_youtube varchar check (url_youtube is null or url_youtube like 'https://youtu%'),
    url_article varchar check (url_article is null or url_article like 'https://%')
);

insert into stages_projets_tutores 
    select *
    from load_stages_projets_tutores;

-- Views
create or replace view vw_projets_par_an as
select
    extract(year from date_soutenance) as annee,
    count(*) as nombre_projets
from stages_projets_tutores
group by annee
order by annee desc;
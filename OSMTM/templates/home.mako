<%!
    import markdown
%>
<%inherit file="/base.mako"/>
<%def name="id()">home</%def>
<%def name="title()">HOT Task Server - Home Page</%def>
<div class="container">
    <div class="row"> 
    <div class="span9">
    % if jobs:
        % for job in jobs:
            <h4>
                <a href="${request.route_url('job', job=job.id)}">${job.title}</a>
                % if job.is_private:
                <img src="${request.static_url('OSMTM:static/img/lock.gif')}" alt="private" title="private job" />
                % endif
            </h4>
            <p>${markdown.markdown(job.description)|n}</p>
            % if user.is_admin():
            <p align="right">
                <a href="${request.route_url('job_edit', job=job.id)}" class="edit" alt="edit" title="Edit the job">edit</a>
                |
                <a href="${request.route_url('job_delete', job=job.id)}" class="delete" alt="delete" title="Delete the job">delete</a>
            </p>
            % endif
        % endfor
    % endif
    </div>
    </div>
    % if admin:
    <div class="actions">
        <a href="${request.route_url('job_new')}" class="btn">+ Create a new job</a>
    </div>
    % endif
</div>
<script type="text/javascript" src="${request.static_url('OSMTM:static/home.js')}"></script>

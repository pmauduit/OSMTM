<%!
    import markdown
%>
<%inherit file="/base.mako"/>
<%def name="id()">job</%def>
<%def name="title()">Job - ${job.title}</%def>
<div class="container">
    <div class="row">
    <div class="span8">
        <h2>Job: ${job.title}</h2>
        <h3>What and Why?</h3>
        <p>${markdown.markdown(job.description)|n}</p>
        <h3>How?</h3>
        <p>${markdown.markdown(job.workflow)|n}</p>
        % if job.imagery:
        <h3>Imagery URL</h3>
        <%include file="imagery.mako" />
        % endif
        % if current_task:
            <p>You are currently working on
            <a href="${request.route_url('task', job=current_task.job_id, x=current_task.x, y=current_task.y)}">
                ${current_task.x} - ${current_task.y}
            </a>
            </p>
        % else:
        <div>
        <h3>Ready?</h3>
            <div class="row">
                <div class="span2">&nbsp;</div>
                <a class="btn primary input" href="${request.route_url('task_take', job=job.id, checkin=0)}">Take a task</a>
            </div>
            <p class="small">If you're an experienced mapper, you can also <a href="${request.route_url('task_take', job=job.id, checkin=1)}">validate</a> tasks done by the other mappers.</a></p>
        </div>
        % endif
        <hr />
        <h4>Who else is working?</h4>
        <p>
        % if stats['current_users']:
        <ul>
          Users currently working on tasks:
          % for user in stats['current_users']:
          <li>
            % if admin:
            <a href="${request.route_url('user',id=user)}">${user}</a>
            % else:
            <a href="http://www.openstreetmap.org/user/${user}" target="_blank">${user}</a>
            % endif
          </li>
          % endfor
        </ul>
        % endif
        <div class="row">
            <div class="span4">
            % if stats['contributors']:
            <strong>Contributors</strong>
            <ul>
              % for user in stats['contributors']:
              <li>
                % if admin:
                <a href="${request.route_url('user',id=user[0])}">${user[0]}</a><sup><em> ${user[1]}</em></sup>
                % else:
                <a href="http://www.openstreetmap.org/user/${user[0]}" target="_blank">${user[0]}</a><sup><em> ${user[1]}</em></sup>
                % endif
              </li>
              % endfor
            </ul>
            % endif
            </div>
            <div class="span4">
            % if stats['validators']:
            <strong>Validators</strong>
            <ul>
              % for user in stats['validators']:
              <li>
                % if admin:
                <a href="${request.route_url('user',id=user[0])}">${user[0]}</a><sup><em> ${user[1]}</em></sup>
                % else:
                <a href="http://www.openstreetmap.org/user/${user[0]}" target="_blank">${user[0]}</a><sup><em> ${user[1]}</em></sup>
                % endif
              </li>
              % endfor
            </ul>
            % endif
            </div>
        </div>
        </p>
    </div>
    <div class="span8">
        <div id="map"></div>
        <div id="stats">
            <ul class="legend">
                <li><div class=""></div>Total (${len(job.tiles)})</li>
                <li><div class="checkin1"></div>Done (${len([x for x in job.tiles if x.checkin == 1 or x.checkin == 2])})</li>
                <li><div class="checkin2"></div>Validated (${len([x for x in job.tiles if x.checkin == 2])})</li>
                <li><div class="checkout"></div>Curr. worked on (${len([x for x in job.tiles if x.checkout != None])})</li>
            </ul>
        </div>
    </div>
    </div>
    % if admin:
    <div class="row">
        <div class="span16">
            <div id="chart_div"></div>
        </div>
    </div>
    % endif
</div>
<script type="text/javascript">
    var geometry = "${job.geometry}";
    var zoom = ${job.zoom};
    var tiles = ${tiles|n};
    var chart_done = ${stats['chart_done']|n};
    var chart_validated = ${stats['chart_validated']|n};
</script>
<script type="text/javascript" src="${request.static_url('OSMTM:static/OpenLayers.js')}"></script>
<script type="text/javascript" src="${request.static_url('OSMTM:static/Div.js')}"></script>
<script type="text/javascript" src="${request.static_url('OSMTM:static/Static.js')}"></script>
<script type="text/javascript" src="${request.static_url('OSMTM:static/highcharts.js')}"></script>
<script type="text/javascript" src="${request.static_url('OSMTM:static/job.js')}"></script>

function out = stencil(u,subx,suby,bc)

[r,c] = size(u);

if round(subx) == subx && round(suby) == suby 
    fr = ceil(max(abs(subx),abs(suby)));
    u_help = make_bound(u,fr,bc);
    out = u_help(fr+1+subx:fr+r+subx,fr+1+suby:fr+c+suby);    
end

if round(subx) ~= subx
    out = (stencil(u,floor(subx),suby,bc)+stencil(u,ceil(subx),suby,bc))/2;       
end

if round(suby) ~= suby
    out = (stencil(u,subx,floor(suby),bc)+stencil(u,subx,ceil(suby),bc))/2;       
end
